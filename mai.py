import configparser
import sys
from langchain.llms import OpenAI
from langchain.prompts import PromptTemplate
from langchain.chains import LLMChain


# The main function.
class AIAssistant:
    def __init__(self, config_file_path: str):
        self.config_file_path = config_file_path


    def load_config(self):
        config_parser = configparser.ConfigParser()
        config_parser.read(self.config_file_path)

        api_key = config_parser.get("openai", "api_key")

        return api_key

    def generate_response(self, prompt: str) -> str:
        """Generates a response to the given prompt, taking into account past interactions and the config variables."""


        template = """Question: {question}
        Answer: Let's think step by step."""

        prompt = PromptTemplate(template=template, input_variables=["question"])

        llm = OpenAI(openai_api_key=self.api_key)
        llm_chain = LLMChain(prompt=prompt, llm=llm)
        question = "What NFL team won the Super Bowl in the year Justin Beiber was born?"

        response = llm_chain.run(question)





        # Return the response.
        return response

    def command_line_chat(self):
        """Starts a command-line chat interaction with the user."""

        print("Welcome to the AI Assistant!")

        # Load the config variables from the config file.
        api_key = self.load_config()

        # Set the config variables on the OpenAI client.
        self.api_key = api_key

        # Keep prompting the user for input until they quit.
        while True:
            user_input = input("What would you like to do? ")

            # If the user enters "quit", exit the chat loop.
            if user_input == "quit":
                break

            # Generate a response to the user's input.
            response = self.generate_response(prompt=user_input)

            # Print the response to the user.
            print(response)

if __name__ == "__main__":
    # Get the path to the config file from the user.
    config_file_path = input("Enter the path to the config file: ")

    # Create an AI assistant.
    ai_assistant = AIAssistant(config_file_path=config_file_path)

    # Start the command-line chat interaction.
    ai_assistant.command_line_chat()
