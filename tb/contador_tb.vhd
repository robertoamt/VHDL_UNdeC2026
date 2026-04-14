entity contador_tb is
end entity contador_tb;

architecture test_contador of contador_tb is
    component contador
    port(
        clk, rst :in std_logic;
        s :out std_logic_vector(3 down to 0);
    );
    end component;

    signal tb