// =============================================================================
// TRAINING 03: AI-Assisted Code Review & Editing
// =============================================================================
// This file contains intentionally imperfect Java code.
// Use CodeCompanion to review, explain, and refactor it.
//
// PREREQUISITE: ANTHROPIC_API_KEY must be set in your environment.
// =============================================================================

import java.util.*;
import java.util.stream.*;

// ---------------------------------------------------------------------------
// EXERCISE 1: Ask AI to explain code
// ---------------------------------------------------------------------------
// Put cursor inside the method below.
// Type vif to select the function body.
// Then type:   :CodeCompanion explain this code step by step
//
// Read the AI's explanation in the chat buffer.

public class Training {

    public static int mysteryFunction(int[] arr) {
        int n = arr.length;
        int[][] dp = new int[n][n];

        for (int i = 0; i < n; i++) {
            dp[i][i] = 1;
        }

        for (int len = 2; len <= n; len++) {
            for (int i = 0; i <= n - len; i++) {
                int j = i + len - 1;
                if (arr[i] == arr[j] && len == 2) {
                    dp[i][j] = 2;
                } else if (arr[i] == arr[j]) {
                    dp[i][j] = dp[i + 1][j - 1] + 2;
                } else {
                    dp[i][j] = Math.max(dp[i + 1][j], dp[i][j - 1]);
                }
            }
        }
        return dp[0][n - 1];
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 2: AI code review - find bugs
    // ---------------------------------------------------------------------------
    // Select the entire method with vaf.
    // Type:   :CodeCompanion review this for bugs and edge cases
    //
    // There are at least 3 issues. See if the AI catches them all.

    public static double calculateAverage(List<Integer> numbers) {
        int sum = 0;
        for (int i = 0; i <= numbers.size(); i++) {
            sum += numbers.get(i);
        }
        return sum / numbers.size();
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 3: AI refactor - modernize Java
    // ---------------------------------------------------------------------------
    // Select the method with vaf.
    // Type:   :CodeCompanion refactor using Java streams and modern idioms
    //
    // Review the suggestion. ga to accept, gr to reject.

    public static List<String> filterAndTransform(List<String> input) {
        List<String> result = new ArrayList<>();
        for (int i = 0; i < input.size(); i++) {
            String s = input.get(i);
            if (s != null && !s.isEmpty()) {
                String trimmed = s.trim();
                if (trimmed.length() > 3) {
                    result.add(trimmed.toUpperCase());
                }
            }
        }
        Collections.sort(result);
        return result;
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 4: AI inline edit - add error handling
    // ---------------------------------------------------------------------------
    // Select the method with vaf.
    // Type:   :CodeCompanion add null checks and proper error handling
    //
    // Compare the before/after with the inline diff.

    public static Map<String, List<Integer>> groupByFirstLetter(String[] words) {
        Map<String, List<Integer>> groups = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            String key = words[i].substring(0, 1).toUpperCase();
            if (!groups.containsKey(key)) {
                groups.put(key, new ArrayList<>());
            }
            groups.get(key).add(i);
        }
        return groups;
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 5: AI chat - discuss design
    // ---------------------------------------------------------------------------
    // Open a chat:   :CodeCompanionChat
    // Type in the chat buffer:
    //
    //   This class mixes static utility methods. How should I restructure
    //   it? Should I use a service pattern, or keep it functional?
    //   Consider that this will be used in a microservice context.
    //
    // Use #buf to include this file as context in the chat.

    // ---------------------------------------------------------------------------
    // EXERCISE 6: Review a specific change with visual selection
    // ---------------------------------------------------------------------------
    // Scenario: someone changed the sorting below from mergeSort to this.
    // Select lines 116-131 with V then j to extend.
    // Type:   :CodeCompanion review: is this sort correct? what's the complexity?

    public static void questionableSort(int[] arr) {
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr.length - 1; j++) {
                if (arr[j] > arr[j + 1]) {
                    int temp = arr[j];
                    arr[j] = arr[j + 1];
                    arr[j + 1] = temp;
                }
            }
        }
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 7: Multi-step AI workflow
    // ---------------------------------------------------------------------------
    // This is a realistic workflow combining vim motions + AI:
    //
    // Step 1: Navigate
    //   /parseConfig        search for the method
    //   gd                  jump to definition (if LSP resolves it)
    //
    // Step 2: Understand
    //   vaf                 select the function
    //   :CodeCompanion explain what this does and what could go wrong
    //
    // Step 3: Review
    //   :CodeCompanion review for security issues (injection, resource leaks)
    //
    // Step 4: Fix
    //   vif                 select body only
    //   :CodeCompanion fix the issues you identified
    //   ga / gr             accept or reject
    //
    // Step 5: Verify
    //   :Trouble diagnostics    check for any new warnings
    //   ]d / [d                 jump through them

    public static Map<String, String> parseConfig(String raw) {
        Map<String, String> config = new HashMap<>();
        String[] lines = raw.split("\n");
        for (String line : lines) {
            String[] parts = line.split("=");
            config.put(parts[0], parts[1]);
        }
        return config;
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 8: Action palette exploration
    // ---------------------------------------------------------------------------
    // Select any method with vaf, then:
    //   :CodeCompanionActions
    //
    // Browse the palette. Try each action:
    //   - Explain
    //   - Review
    //   - Refactor
    //   - Generate tests
    //   - Add documentation
    //
    // This is the fastest way to do AI-assisted code review.

    // ---------------------------------------------------------------------------
    // EXERCISE 9: Combine surround + AI
    // ---------------------------------------------------------------------------
    // Sometimes you need to prep code before sending to AI.
    //
    // 1. The string below needs quotes fixed:
    //    Put cursor on message. Type cs'` to change ' to backtick.
    //
    // 2. Wrap the return in Optional:
    //    Type ysiw) on result to get (result), then i to prepend Optional.of

    public static String buildMessage() {
        String template = 'Hello, {name}';
        String result = template.replace("{name}", "World");
        return result;
    }

    // ---------------------------------------------------------------------------
    // EXERCISE 10: Full review workflow (putting it all together)
    // ---------------------------------------------------------------------------
    // Pretend this class was submitted as a PR. Review it end-to-end:
    //
    // 1. gg                    go to top of file
    // 2. ]]                    jump to first method
    // 3. vaf                   select it
    // 4. :CodeCompanionActions -> Review
    // 5. Read the feedback
    // 6. ]]                    next method
    // 7. Repeat for each method
    //
    // Finally:
    // 8. :CodeCompanionChat
    // 9. "Summarize all issues found in this file. Prioritize by severity."
    //    (use #buf to attach the file)
    //
    // This is how you do AI-assisted code review efficiently.
}
