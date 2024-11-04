ENTITY mux2x4 IS
    PORT (
        a0, a1, a2, a3, b0, b1, b2, b3, sel : IN BIT;
        z0, z1, z2, z3 : OUT BIT);
END ENTITY mux2x4;

ARCHITECTURE struct OF mux2x4 IS
BEGIN
    bit0 : ENTITY work.mux2(behav) PORT MAP (a0, b0, sel, z0);
    bit1 : ENTITY work.mux2(behav) PORT MAP (a1, b1, sel, z1);
    bit2 : ENTITY work.mux2(behav) PORT MAP (a2, b2, sel, z2);
    bit3 : ENTITY work.mux2(behav) PORT MAP (a3, b3, sel, z3);
END ARCHITECTURE struct;
