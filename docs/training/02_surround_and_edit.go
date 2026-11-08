// =============================================================================
// TRAINING 02: Surround, Editing Patterns & LSP in Go
// =============================================================================
// Open this file in Neovim. Follow each exercise.
// Your Go LSP (gopls) should be active for LSP exercises.
// =============================================================================

package training

import (
	"fmt"
	"strings"
	"errors"
)

// ---------------------------------------------------------------------------
// EXERCISE 1: Surround - Add quotes
// ---------------------------------------------------------------------------
// Put cursor on the word hello below (on the h).
// Type ysiw" to surround it with double quotes.
// Then try ysiw` to surround with backticks (undo first with u).

var message = hello

// ---------------------------------------------------------------------------
// EXERCISE 2: Surround - Change surrounding
// ---------------------------------------------------------------------------
// Put cursor inside the single quotes below.
// Type cs'" to change single quotes to double quotes.
// Then type cs"( to change double quotes to parentheses.

var name = 'world'

// ---------------------------------------------------------------------------
// EXERCISE 3: Surround - Delete surrounding
// ---------------------------------------------------------------------------
// Put cursor inside the parentheses below.
// Type ds( to remove the parentheses.
// Undo with u. Try ds" on the string literal too.

var wrapped = (unnecessaryParens)
var quoted = "remove these quotes"

// ---------------------------------------------------------------------------
// EXERCISE 4: Surround - Visual mode
// ---------------------------------------------------------------------------
// Select the error message text below with vi" (inside quotes).
// Then press S( to wrap it in parens.
// Undo. Now try: viw then S" to quote a single word.

func validateAge(age int) error {
	if age < 0 {
		return errors.New("age cannot be negative")
	}
	if age > 150 {
		return errors.New("age seems unrealistic")
	}
	return nil
}

// ---------------------------------------------------------------------------
// EXERCISE 5: Change inside patterns (ci)
// ---------------------------------------------------------------------------
// These are the most useful editing combos in Go:
//
// Put cursor inside the fmt.Sprintf call below.
// ci( -> change the arguments (delete + enter insert mode)
//
// Put cursor inside the struct literal.
// ci{ -> change the struct fields

type User struct {
	Name  string
	Email string
	Age   int
}

func createUser() User {
	name := fmt.Sprintf("%s %s", "John", "Doe")
	_ = name
	return User{Name: "Jane", Email: "jane@example.com", Age: 30}
}

// ---------------------------------------------------------------------------
// EXERCISE 6: Multi-line editing with visual block
// ---------------------------------------------------------------------------
// Put cursor on the "n" of "name" on the first field line.
// Ctrl-v -> enter visual block mode
// 2j     -> extend selection down 2 lines
// I      -> insert before block
// user.  -> type "user."
// Esc    -> applies to all lines
//
// This turns:
//   name
//   email
//   age
// Into:
//   user.name
//   user.email
//   user.age

func printFields() {
	name := "test"
	email := "test@test.com"
	age := 25

	fmt.Println(name)
	fmt.Println(email)
	fmt.Println(age)
}

// ---------------------------------------------------------------------------
// EXERCISE 7: LSP actions
// ---------------------------------------------------------------------------
// Put cursor on "ProcessItems" below.
// gd     -> go to definition
// Ctrl-o -> jump back
// K      -> show hover documentation
// gr     -> show references
//
// Put cursor on the error return.
// ]d / [d -> jump between diagnostics (if any)

func ProcessItems(items []string) ([]string, error) {
	if len(items) == 0 {
		return nil, errors.New("empty items")
	}

	result := make([]string, 0, len(items))
	for _, item := range items {
		processed := strings.TrimSpace(item)
		if processed != "" {
			result = append(result, strings.ToUpper(processed))
		}
	}
	return result, nil
}

// ---------------------------------------------------------------------------
// EXERCISE 8: Indent/dedent with text objects
// ---------------------------------------------------------------------------
// Put cursor inside the if block below.
// >i{ -> indent inside braces
// <i{ -> dedent inside braces
// =af -> auto-format the function (if LSP supports it)

func messyIndentation() {
if true {
fmt.Println("fix")
fmt.Println("my")
fmt.Println("indentation")
}
}

// ---------------------------------------------------------------------------
// EXERCISE 9: Registers and paste
// ---------------------------------------------------------------------------
// Go to the first fmt.Println below. Type yy to yank the line.
// Move to after the third Println. Type p to paste below.
//
// Now try named registers:
// "ayy  -> yank line into register a
// "byy  -> yank another line into register b
// "ap   -> paste from register a
// "bp   -> paste from register b

func registerPractice() {
	fmt.Println("line one")
	fmt.Println("line two")
	fmt.Println("line three")
}

// ---------------------------------------------------------------------------
// EXERCISE 10: Dot repeat (.)
// ---------------------------------------------------------------------------
// The dot . repeats your last change. Incredibly powerful.
//
// Put cursor on the first "err" below. Type ciw to change it to "error".
// Press Esc. Now press n to find next "err", then . to repeat the change.
// Continue n . n . to fix all of them.
//
// (First search with /err\b to find whole-word matches)

func dotPractice() {
	err := validateAge(25)
	if err != nil {
		fmt.Println(err)
	}
	err = validateAge(-1)
	if err != nil {
		fmt.Println(err)
	}
}
