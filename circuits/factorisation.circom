pragma circom 2.1.4;

template Factorisation() {
    signal input num1;
    signal input num2;

    signal input expectedOp;

    signal prod <== num1 * num2;

    expectedOp === prod;
}

component main { public [expectedOp] } = Factorisation();