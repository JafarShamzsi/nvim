local M = {}

-- Function to handle Ollama responses
function M.handle_ollama_data(data_stream)
  local success, json = pcall(vim.json.decode, data_stream)
  if success then
    if json.response then
      require("dingllm").write_string_at_cursor(json.response)
    end
  else
    print("Error parsing Ollama response: " .. data_stream)
  end
end

-- Function to make Ollama curl arguments
function M.make_ollama_curl_args(opts, prompt)
  local url = opts.url or "http://localhost:11434/api/generate"
  local data = {
    model = opts.model or "codellama",
    prompt = prompt,
    stream = true
  }
  return {
    "-N",
    "-X", "POST",
    "-H", "Content-Type: application/json",
    "-d", vim.json.encode(data),
    url
  }
end

-- Function to invoke Ollama
function M.invoke_ollama(replace)
  require("dingllm").invoke_llm_and_stream_into_editor({
    url = "http://localhost:11434/api/generate",
    model = "codellama",
    replace = replace,
  }, M.make_ollama_curl_args, M.handle_ollama_data)
end

return M 