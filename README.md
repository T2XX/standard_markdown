# standard_markdown

A flutter markdown package which support GFM/CommonMark standard

# How To Use

```dart
import 'package:standard_markdown/standard_markdown.dart'; // import package
StandardMarkdown(markdown) // use Widget
```

# TODO

It will be finish before 1.0.0 stable

## Support editing modes

- [ ] Instant rendering (ir)
- [x] Split view (sv)

## All CommonMark syntax

- [x] Divider line
- [x] Code block (support syntax highlighting) (unhandle language detect)
- [ ] HTML block (XSS filtering)
- [x] Link
- [x] Quote
- [x] Paragraph
- [x] List
- [x] Backslash escape
- [x] Emphasis
- [x] Bold
- [x] Image
- [x] Text content

## All GFM syntax

- [x] Table
- [x] Task list item (unhandle click change check)
- [x] Strikethrough
- [x] Automatic link

## Other

- [x] Footnote
- [ ] search
- [ ] formate
- [ ] ToC
- [x] Latex/KaTex(`$`and `$$`)
- [ ] ECharts(use in ` ``` `block)
- [ ] Easy to use (controller controls everything)
- [ ] toolbar
- [ ] loadFromString
- [ ] loadFromselectFile
- [ ] rebuild by getx controller
