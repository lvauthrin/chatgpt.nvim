# chat-gpt.nvim [![main branch](https://github.com/lvauthrin/chatgpt.nvim/actions/workflows/default.yml/badge.svg)](https://github.com/lvauthrin/chatgpt.nvim/actions/workflows/default.yml)

This repo contains a Neovim Lua plugin to make requests to ChatGPT and output the answer inside the buffer.  Although this plugin works, it's a WIP which I'm using as a learning playground for Neovim/Lua.  For a more robust plugin, see [jackMort/ChatGPT.nvim](https://github.com/jackMort/ChatGPT.nvim).

## Usage

To make requests via the ChatGPT API, you'll need to get an API KEY and export it to the `OPENAI_API_KEY` env var.
```bash
# This can also be set in your shell's config
export OPENAI_API_KEY = <YOUR API KEY HERE>
```

Then use a plugin manager (e.g like lazy.nvim) to install the plugin:
```lua
return {
  {
    "lvauthrin/chatgpt.nvim",
    lazy = false,
    config = function(_, _)
      require("chatgpt").setup({ api_key = os.getenv("OPENAI_API_KEY") })
    end,
  },
}
```

### Make a request based on the current line

Move the cursor to the line that has the promp and type `:ChatGPT`.  This will send the prompt to ChatGPT and output the answer on the next line in the current buffer.  
**Note:** The call is synchronous and blocks everything until it's done.

### Make a request by passing in an argument
Type in `:ChatGPT` followed by your prompt.  For example: `:ChatGPT Show me the code for splitting a string into an array in lua`.  Again, this will output the answer on the next line in the current buffer.

## TODO:
* Allow the user to see all the responses from the request (currently only the first is shown) 
* Figure out whether prompt should go inside comments or outside of comments
* Add proper tests


