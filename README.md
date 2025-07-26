# 🧠 Link Mindmap Generator

A command-line toolkit designed to extract and visualize links exported from your browser (e.g., from saved sessions, history, or extensions like "Export Tabs URLs") as **interactive mind maps**. It provides comprehensive support for categorizing and enriching various link types, including YouTube videos, technical documentation, AI resources, GitHub repositories, and Reddit threads.

## 🎯 Key Features

*   Organize thousands of saved links into a visual and meaningful structure.
*   Extend YouTube video metadata (title, views, publication date) for richer context.
*   Generate `.md` mind map files compatible with [Markmap](https://markmap.js.org/).
*   Enable chronological and thematic analysis of collected links.
*   Classify links by type (YouTube, GitHub, Google AI, Reddit, etc.) for better organization.

## 🔧 Technologies Used

*   `bash`
*   `yt-dlp`
*   `jq`
*   `markmap-cli`
*   `Node.js` and `npm` (for `markmap-cli`)
*   Markmap (for visualization)

## 🚀 Setup and Usage

### Prerequisites

*   Linux/macOS (or Windows with WSL)
*   `jq`
*   `yt-dlp`
*   `node` and `npm`

### Installation

1.  Clone the repository:
    ```bash
    git clone https://github.com/tuo-username/link-mindmap-generator.git
    cd link-mindmap-generator
    ```
2.  Install dependencies:
    ```bash
    pip install -r requirements.txt
    npm install -g markmap-cli
    ```

### Usage Workflow

1.  **Add your exported browser files**: Place your `.txt` files inside the `data/` directory. These files should contain alternating lines of **title / URL**, as typically exported by browser extensions like "Export Tabs URLs".
2.  **Extract links to JSON**:
    ```bash
    ./scripts/extract_links_to_json.sh
    ```
3.  **(Optional) Extract YouTube metadata**: To enrich YouTube links with title, views, and publication date:
    ```bash
    ./scripts/generate_youtube_metadata.sh
    ```
4.  **Generate the mind map**:
    ```bash
    ./scripts/generate_markmap_from_json.sh
    ```
5.  **Visualize the mind map**:
    You can open the generated `output/markmap_links.md` file using the `markmap-cli`:
    ```bash
    npx markmap-cli output/markmap_links.md
    ```
    Alternatively, paste the content of `output/markmap_links.md` directly into the online Markmap REPL: [markmap.js.org/repl](https://markmap.js.org/repl/)
