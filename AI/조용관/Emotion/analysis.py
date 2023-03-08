pip install -q transformers
###########################################################################

from transformers import pipeline
sentiment_pipeline = pipeline("sentiment-analysis")
data = ["I feel lonely today", "I'm happy today", "When I have concerns, I look up at the sky", "Today feels like an incredibly long day", "I want to scream out loud today"]
sentiment_pipeline(data)
############################################################################

specific_model = pipeline(model="finiteautomata/bertweet-base-sentiment-analysis")
specific_model(data)