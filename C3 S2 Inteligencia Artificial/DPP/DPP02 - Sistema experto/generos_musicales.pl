% en que años se popularizó el género
decada_genero(1920, jazz).
decada_genero(1990, electronica).
decada_genero(2000,dubstep).
decada_genero(1930, swing).
decada_genero(1930, samba).
decada_genero(1957, bossa_nova).

genero_derivado(bossa_nova, samba).
genero_derivado(bossa_nova, jazz).
genero_derivado(dubstep, electronica).
genero_derivado(swing, jazz).


get_decada_genero(ANHO,GENERO):-
    decada_genero(ANHO,GENERO).

relacion_entre_generos(DERIVADO, BASE):-
    genero_derivado(DERIVADO, BASE).

es_moderno(GENERO):-
    decada_genero(Decada, GENERO),
    Decada >= 1980.

mismos_anhos(GENERO1, GENERO2) :-
    decada_genero(ANHO, GENERO1),
    decada_genero(ANHO, GENERO2),
    GENERO1 \= GENERO2.

misma_raiz(GENERO1, GENERO2):-
    relacion_entre_generos(GENERO1, RAIZ1),
    relacion_entre_generos(GENERO2, RAIZ2),
    RAIZ1 == RAIZ2,
    GENERO1 \= GENERO2.

% ?- misma_raiz(GENERO, swing)
% ?- mismos_anhos(samba, GENERO2)
% ?- es_moderno(GENERO)
% ?- relacion_entre_generos(HIJOS,jazz)
% ?- get_decada_genero(ANHO,dubstep)
