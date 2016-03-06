# ScribeDown

ScribeDown is a simple way to author PDF documents. It merges many MarkDown, HTML, CSV, CSS or ERB files into one HTML file - which is then pushed through PDFKit to generate a document that can be easily emailed or printed.

## Getting started

Install ScribeDown through RubyGems

    gem install scribedown

Create a new document skeleton

    scribe init

Generate a PDF from the initial document

    scribe generate
    
Create a new section of your document

    scribe create new_section.md

## Using sections & scribe.yml

Sections are used to split up your document into manageable pieces, or to keep different formats apart. A section can be made with the `scribe create` command, or by adding an entry into the `scribe.yml` file and making a new file in the `sections` folder.

As well as defining sections in `scribe.yml` you can also change the how the page is styled and formatted. The default settings is like so:

    default:
      format: auto
      base: index.html.erb
      container: section.html.erb
      styles:
        - style.css
      output:
        default: all
        html: index.html
        pdf: document.pdf
      classes: ''
    
    sections:
      - my_section
      - another_section
        format: markdown

| Key    | Use |
| -------| ----|
| `format` | The format to use for all files. `auto` means that the file extension will determine the format. Supported extensions are `.md`, `.markdown`, `.html`, `.csv` or any of those with `.erb` |
| `base` | The ERB file to use to generate the whole document. Not recommended to override. |
| `container` | The ERB file to use to render a single section. Can be useful to override if you want extra markup in your final HTML. |
| `styles` | The stylesheets to copy into the final output. Use `extra_styles` to add to the default styles. |
| `output` | Determines what should be generated and the file names. |
| `classes` | HTML classes to add to each section. These can also be added to each section individually. |

CSV files will be rendered as HTML tables.
