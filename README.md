# standard_markdown

A flutter markdown package which support GFM/CommonMark standard

# How To Use

```dart
import 'package:standard_markdown/standard_markdown.dart';
            StandardMarkdown(
            oninit: (config) {
              
            },
            mode: 0,
            toolbar: true,
            selectable: true,
            data: editingController)
```

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
- [x] Task list item (unhandle click change check state)
- [x] Strikethrough
- [x] Automatic link

## Other

- [ ] Footnote
- [ ] search
- [x] formate markdown
- [ ] ToC
- [x] Latex/KaTex
- [ ] ECharts
- [x] Easy to use
- [x] toolbar
- [x] a controller control all
- [x] select in material 3
