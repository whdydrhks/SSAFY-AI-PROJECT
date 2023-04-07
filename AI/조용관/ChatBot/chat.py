!pip install kobert-transformers==0.4.1
!pip install transformers==3.0.2
!pip install torch
!pip install tokenizers==0.8.1rc1
#############################################

!git clone https://github.com/hoit1302/kobert-wellness-chatbot.git

##############################################
cd ./kobert-wellness-chatbot

##############################################
# mkdir checkpoint

##############################################
%run ./model/classifier.py

##############################################
%run ./model/configuration.py

##############################################
pip install sentencepiece

##############################################
%run ./model/dataloader.py

##############################################
%run ./train.py

##############################################
%run ./test.py
