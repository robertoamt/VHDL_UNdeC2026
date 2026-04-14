library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity contador
Port(
    clk, rst :in std_logic;
    s :out std_logic_vector(3 down to 0);
);

architecture cont of contador is 
signal cuenta: unsigned(3 downto 0):= (others => '0');
begin

process(clk,rst)
begin
    if reset = '1' then
        cuenta <= (others => '0');
    elsif rising_edge(clk) then
        cuenta <= cuenta + 1;
    end if;
    end process;

q <= STD_LOGIC_VECTOR(cuenta);
end architecture;