import spacy
from spacy.lang.en.stop_words import STOP_WORDS
import re
import contextualSpellCheck

import spacy
from spacy.lang.en.stop_words import STOP_WORDS
import re
import contextualSpellCheck

import spacy
from spacy.lang.en.stop_words import STOP_WORDS
import re
import contextualSpellCheck


def normalize_text(text):
    # Load English SpaCy model
    nlp = spacy.load('en_core_web_sm')

    # Añado el corrector ortográfico contextual al pipeline de SpaCy de forma que se aplique al todo
    if 'contextual spellchecker' not in nlp.pipe_names:
        contextualSpellCheck.add_to_pipe(nlp)

    # nlp.enable_pipe('contextual spellchecker')

    # Convert to lowercase
    texto = text.lower()

    # Remove numbers that aren't part of words
    text = re.sub(r'\b\d+\b', '', text)

    # Corrector ortográfico
    doc_con_errores = nlp(text)

    # Procesar texto (2ª vuelta)
    doc = nlp(doc_con_errores._.outcome_spellCheck)

    # Process text with SpaCy
    normalized_tokens = []

    for token in doc:
        # Skip stop words
        if token.text in STOP_WORDS:
            continue

        # Skip punctuation and spaces
        if token.is_punct or token.is_space:
            continue

        normalized_tokens.append(token)

    # Join tokens into normalized text
    normalized_text = ' '.join([token.text for token in normalized_tokens])

    return normalized_text, normalized_tokens, doc


if __name__ == "__main__":

    texto = "Everyone was working harrd, but John was not working hard enough. By 5:00 , he had only completed 2 out of 10 tasks. He was supposed to finish all the tasks by 6:00. He was in trouble."

    normalized_texto, normalized_tokens, doc = normalize_text(texto)
    print("Normalized text:", normalized_texto)
    print("Normalized tokens:", normalized_tokens)
    print("Original tokens:", doc)

