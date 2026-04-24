# Engineering Guide

- Always use SOLID principles when writing code.
- Always read files with the `Read` tool. Avoid using `bat`, `cat`, `less`, `more`, etc where possible.
- In TypeScript/JavaScript/Vue files, if you do not know where an import alias comes from, you can typically find them defined in `tsconfig.json` or `vite.config.ts`.
- When running TS/JS tests, you can determine the test runner by looking in the test file or the `package.json` in the project. Typically, it's going to be Vitest or Jest. Run tests with the configured package manager (e.g. `pnpm vitest run`, `yarn vitest run`, etc).

## Tickets

- Be clear yet concise.
- Describe the problem, but avoid solutions unless instructed otherwise.
- Create all tickets as stories unless instructed otherwise.
- After creating a ticket, print the ticket URL.

## Ruby

- Prefer shorthand hashes (e.g. `{ key: }` instead of `{ key: key }`).
- Prefer symbols over strings where possible (e.g. hashes, values, etc).
- Always alphabetize array literals, hash keys, method definitions, etc where possible.
- Avoid using `delegate` where possible, as it can make code more difficult to follow.

### RSpec

- Use `subject(:instance) { Thing.new }` as the subject when testing class instances.
- Use `describe ".call"` and `describe "#call"` syntax when testing class and instance methods, respectively.
- Use `subject { described_class.thing }` and `subject { instance.thing }` directly inside `describe` blocks when testing class and instance methods, respectively.
- Always alphabetize `describe`, `context`, and `it` blocks where possible (and it makes sense).
- Use `it { is_expected.to eq(thing) }` syntax for simple assertions and `it "does the thing" do` syntax for more complex assertions. When using the latter form, use `expect(subject)` instead of `is_expected`.
- Prefer `eq` over `be`, even for booleans, strings, symbols, etc. Prefer `eq(nil)` over `be_nil`, `eq([])` over `be_empty`, `eq(true)` over `be(true)`, etc.
