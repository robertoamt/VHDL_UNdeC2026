library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ffd_tb is --tb --> entidad vacia, no tiene E/S
end entity ffd_tb;

architecture sim of ffd_tb is
--declarativa señales y componentes
    component ffd
        port (
        d : in std_logic;--
        clk : in std_logic;--
        rst : in std_logic;--
        q : out std_logic;
        nq : out std_logic
        );
    end component;
    signal d_tb, nq_tb, q_tb, rst_tb : std_logic;
    signal clk_tb : std_logic := '0';
    constant clk_period : time := 20 ns;
begin
--mapeo de componente y estimulos
    ffd_inst1: ffd
    port map(
        d => d_tb,
        nq => nq_tb,
        clk => clk_tb,
        q => q_tb,
        rst => rst_tb
    );

    clk_tb <= not clk_tb after clk_period/2;

    estimulos_d: process
	begin
    wait for clk_period;-- esperar 10ns
    d_tb <= '0';
    for i in 2 to 4 loop--for (int i=2;i<4; i++ )
    	wait for clk_period*i;
    	d_tb <= not d_tb;
    end loop;	
    wait;
	end process;

    rst_tb <= '1', '0' after 30 ns, '1' after 200 ns; 

end architecture;



