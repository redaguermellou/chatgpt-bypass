#!/bin/sh

# Set your OpenAI API key
export CHATGPT_TOKEN="your_api_key_here"
# Set the appropriate model name
model_name="gpt-3.5-turbo"

echo "\n[+] Input: $1"
echo "\n[+] Output:" 

api_response=$(curl -s https://api.openai.com/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $CHATGPT_TOKEN" \
  -d '{
  "model": "'"$model_name"'",
  "messages": [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "'"$1"'"}
  ],
  "max_tokens": 4000,
  "temperature": 1.0
}' \
--insecure)

echo "\n[+] API Response:"
echo "${api_response}"

curl_output=$(echo "${api_response}" | jq -r '.choices[0]?.message?.content')

if [ "$curl_output" = "null" ]; then
  echo "No valid response received."
else
  echo "${curl_output}"
fi
