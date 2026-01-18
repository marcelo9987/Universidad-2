import {gql} from 'apollo-server';
// --- TIPOS DE OBXECTO (OBJECT TYPES) ---

export const typeDefs = gql`
    """
    Representa un videoxogo no sistema .
    Ten relacións coa desarrolladora e as recensións .
    """
    type Game {
        _id: ID!
        title: String !
        description : String
        price: Float!
        releaseYear : Int!
        genre: String
        # Encadeamento : Un xogo pertence a unha desarrolladora
        developer : Developer !
        # Encadeamento : Un xogo ten múltiples recensións
        reviews (limit: Int): [Review !]
        averageRating : Float
        }
        
    """
    Empresa ou persoa que crea os videoxogos .
    """
    type Developer {
        _id: ID!
        name: String !
        country : String
        foundedYear : Int
        # Encadeamento : Unha desarrolladora ten moitos xogos
        games: [Game !]
        }
    """
    Opinión dun usuario sobre un xogo específico .
    """
    type Review {
        _id: ID!
        content : String !
        rating : Int! # De a     createdAt : String !
        # Encadeamento : Quen escribiu a recensión
        author : User!
        }
    """
    Usuario da plataforma .
    """
    type User {
        _id: ID!
        username : String !
        email: String !
        # Lista de xogos comprados ou favoritos
        library : [Game]!
        }
    # --- CONSULTAS ( QUERIES ) ---
    type Query {
        """
        Obtén o catálogo de xogos con paxinación .
        page: Número de páxina (comeza en 1).
        pageSize : Cantidade de elementos por páxina .
        """
        getGames (page: Int, pageSize : Int): [Game ]!
        """
        
        Busca un xogo polo seu ID único.
        """
        getGameById (id: ID!): Game
            """
        Busca xogos por xénero (ex: 'RPG ', 'FPS ').
        Tamén soporta paxinación básica .
        """
        getGamesByGenre (genre: String !, limit: Int = 5): [Game !]!
            """
        Listaxe de tódalas desarrolladoras rexistradas .
        """
        getDevelopers : [ Developer !]!
        getDeveloper (id:ID!): Developer!
                """
        Devolve o usuario autenticado actualmente baseándose no token da
        cabeceira .
        """
        me: User
        }
    # --- MUTACIÓNS ( MUTATIONS ) ---
    # Argumentos pasados directamente .
    type Mutation {
        # --- Autenticación ---
            """
        Rexistra un novo usuario .
        Devolve directamente o token (String ) para autenticación futura .
        """
        signup ( username : String !, email: String !, password : String !): String !
            """
        Inicia sesión .
        Devolve directamente o token JWT (String ).
        """
        login(email: String !, password : String !): String !
       
            # --- Xestión de Desenvolvedoras ---
        """
        Crea unha nova desarrolladora .
        """
        createDeveloper (
            name: String !,
            country : String ,
            foundedYear : Int
        ): Developer !
        
            # --- Xestión de Xogos ---
        """
        Crea un novo videoxogo .
        Require o ID da desarrolladora existente .
        """
        createGame (
            title: String !,
            description : String ,
            price: Float!,
            releaseYear : Int ,
            genre: String !,
            developerId : ID!
        ): Game!
            """
        Actualiza o prezo dun xogo existente .
        """
        updateGamePrice (id: ID!, newPrice : Float !): Game!
            """
        Elimina un xogo do catálogo .
            Devolve true se foi borrado correctamente .
        """
        deleteGame (id: ID!): Boolean !
            # --- Interaccións ---
            """
        Engade unha recensión a un xogo.
        O autor dedúcese do token de autenticación ( Contexto ).
        """
            addReview (
            gameId : ID!,
            content : String !,
            rating : Int!
        ): Review !
         """
        Engade un xogo á biblioteca persoal do usuario autenticado .
        """
        addToLibrary (gameId : ID!): User!
        }
`;