int i = h(x);
while ( A[i] != x ){
    if ( A[i] != 0 ){
        i = i - 1;
    }
    else if ( i = 0 ){
        i = m;
    }
    else{
        A[i] = x;
        B[i] = 0;
        break;
    }
}
B[i] = B[i]+1;