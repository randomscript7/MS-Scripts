# Verifier.osts

This is a Microsoft Office script written in TypeScript. It is a algorithm built for verifying accounting journal entries in Excel spreadsheets.

This script requires specific formatting to run. It dynamically adapts to any number of journal entries with any amount of line items, and determines whether the entry is balanced. After all entries are scanned, it determines the final Debit and Credit total for the journal, outputting any unbalanced errors and highlighting the offending entry on the sheet.

It may be more efficient to manually copy-paste the contents of the scripts into the application's code editor as opposed to copying the file itself.