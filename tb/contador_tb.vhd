library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity contador_tb is
end entity contador_tb;

architecture test_contador of contador_tb is
    component contador
    port(
        clk, rst :in std_logic;
        s :out std_logic_vector(3 down to 0);
    );
    end component;

    signal clk, rst : STD_LOGIC := '0';
    signal q : STD_LOGIC_VECTOR (3 downto 0);

    constant Tclk : time := 10 ns;

begin

    -- Instanciación del contador
    uut: contador
        port map (
            clk => clk,
            reset => reset,
            q => q
        );

    -- Generador de reloj
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for Tclk/2;
            clk <= '1';
            wait for Tclk/2;
        end loop;
    end process;

    -- Estímulos
    stim_proc: process
    begin
        -- Reset inicial
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Dejar contar un tiempo
        wait for 200 ns;

        -- Aplicar reset otra vez
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        -- Seguir contando
        wait for 100 ns;

        -- Fin de simulación
        wait;
    end process;

end Behavioral;  