# Write your solution here!
require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))

# Starting message to set assistant behavior
conversation = [
  { "role" => "system", "content" => "You are a helpful assistant." }
]

# Keep chatting until user types "bye"
user_input = ""

while user_input != "bye"
  print "\nYou: "
  user_input = gets.chomp

  break if user_input == "bye"

  # Add user message
  conversation << { "role" => "user", "content" => user_input }

  # Send to OpenAI
  response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: conversation
    }
  )

  # Get assistant response
  reply = response["choices"][0]["message"]["content"]

  # Print and save the reply
  puts "ChatGPT: #{reply}"
  conversation << { "role" => "assistant", "content" => reply }
end

puts "\nChat ended. Goodbye!"
