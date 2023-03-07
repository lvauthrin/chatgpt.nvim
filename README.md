# chat-gpt.nvim

This repo contains a nvim lua plugin to make requests to ChatGPT and output the answer inside the buffer.

## Usage

To make requests via the ChatGPT API, you'll need to get an API KEY and export it to the `OPENAI_API_KEY` env var.
```bash
# This can also be set in your shell's config
export OPENAI_API_KEY = <YOUR API KEY HERE>
```

Then configure the plugin using the following lua code:
```lua
require('chatgpt').setup({
    api_key = os.getenv("OPENAI_API_KEY")
})
```

### Make a request based on the current line

Move the cursor to the line that has the promp and type `:ChatGPT`.  This will send the prompt to ChatGPT and output the answer on the next line in the current buffer.  
**Note:** The call is synchronous and blocks everything until it's done.

### Make a request based on the current line
Type in `:ChatGPT` followed by your prompt.  For example: `:ChatGPT Show me the code for splitting a string into an array in lua`.  Again, this will output the answer on the next line in the current buffer.

## TODO:
* Allow the user to see all the responses from the request (currently only the first is shown) 
* Figure out whether prompt should go inside comments or outside of comments
* Add proper tests


