import nltk
from nltk import RegexpTokenizer, WordNetLemmatizer

DEBUG_ACTIVO = False

nltk.download('punkt')
nltk.download('stopwords')
# nltk.download('averaged_perceptron_tagger')
nltk.download('wordnet')


def normalizacion_nltk(_texto):
    if DEBUG_ACTIVO:
        print("Texto original: ", _texto)

    # Lowercasing
    _texto = _texto.lower()
    if DEBUG_ACTIVO:
        print("Lowercasing: ", _texto)

        # Eliminación de signos de puntuación
        regex_tokenizador = RegexpTokenizer(r'\w+[\.|\,]?')

        if DEBUG_ACTIVO:
            print("Eliminación de signos de puntuación: ", texto)


    # Eliminación de números
    _texto = ''.join([i for i in _texto if not i.isdigit()])
    if DEBUG_ACTIVO:
        print("Eliminación de números: ", _texto)

    # Tokenización
    tokens = regex_tokenizador.tokenize(_texto)
    if DEBUG_ACTIVO:
        print("Tokenización: ", tokens)

    # Eliminación de stopwords
    stopwords = nltk.corpus.stopwords.words('english')
    tokens = [token for token in tokens if token not in stopwords]
    if DEBUG_ACTIVO:
        print("Eliminación de stopwords: ", tokens)

        # Lematización
    # lemmatizer = nltk.stem.WordNetLemmatizer()
    lemmatizer = WordNetLemmatizer()
    tokens = [lemmatizer.lemmatize(token) for token in tokens]
    if DEBUG_ACTIVO:
        print("Lematización: ", tokens)

    # Stemming (Incluido en NLTK)
    stemmer = nltk.stem.SnowballStemmer('english')
    tokens = [stemmer.stem(token) for token in tokens]
    if DEBUG_ACTIVO:
        print("Stemming: ", tokens)

    return tokens


if __name__ == "__main__":
    texto = "Everyone was working hard, but John was not working hard enough. By 5:00 , he had only completed 2 out of 10 tasks. He was supposed to finish all the tasks by 6:00. He was in trouble."
    print(normalizacion_nltk(texto))
