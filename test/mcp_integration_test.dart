// Copyright AGNTCY Contributors (https://github.com/agntcy)
// SPDX-License-Identifier: Apache-2.0

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:gui/mcp/client.dart';

void main() {
  test('Integration: MCP Client connects to local binary', () async {
    var executable = "";
    var args = <String>[];
    final cwd = Directory.current.path;
    final candidates = [
      '$cwd/.bin/dirctl',
      '$cwd/.bin/mcp-server',
    ];

    for (final candidate in candidates) {
      final file = File(candidate);
      if (file.existsSync()) {
        executable = candidate;
        break;
      }
    }

    if (executable.isEmpty) {
      print("CWD: $cwd");
      fail('Executable not found. Tried: ${candidates.join(", ")}. Please build the server first.');
    }

    print('Using binary at: $executable');

    if (executable.endsWith("dirctl")) {
      args = ["mcp", "serve"];
    }

    final client = McpClient(executablePath: executable);

    // 1. Start the process
    // Pass schema URL for OASF validation (required)
    await client.start(args: args, environment: {
      "OASF_API_VALIDATION_SCHEMA_URL": "https://schema.oasf.outshift.com",
    });

    // 2. Initialize
    print('Initializing...');
    await client.initialize();
    print('Initialized.');

    // 3. List Tools
    print('Listing tools...');
    final tools = await client.listTools();

    final toolNames = tools.map((t) => t.name).toList();
    print('Found tools: $toolNames');

    // 4. Verify specific tool exists
    expect(toolNames, contains('agntcy_dir_search_local'));

    // 5. Test Tool Call (Search)
    // We expect it to return an error because we don't pass filters,
    // exactly matching the manual python test result.
    print('Calling search tool...');
    final result = await client.callTool('agntcy_dir_search_local', {"limit": 1});
    print('Result content: ${result.content}');

    // The previous manual test result was:
    // {"count":0,"error_message":"at least one query filter must be provided","has_more":false}
    // embedded in a text content block.

    // Check if we got a response (even if it's the error message from the tool logic)
    // The result.content is usually a List.
    final contentList = result.content as List;
    expect(contentList, isNotEmpty);
    final textObj = contentList.first as Map<String, dynamic>;
    expect(textObj['type'], 'text');
    expect(textObj['text'], contains('at least one query filter must be provided'));

    await client.stop();
  });
}
