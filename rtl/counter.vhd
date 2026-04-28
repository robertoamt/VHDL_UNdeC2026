library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
  Port ( 
        clk_in : in std_logic;
        rst_in : in std_logic;
        data_out : out std_logic_vector(3 downto 0)  
  );
end counter;

architecture Behavioral of counter is

signal counter_signal : unsigned(3 downto 0);

begin

process(clk_in,rst_in)
begin
    if rst_in = '1' then
        counter_signal <= (others => '0');
    else
        if rising_edge(clk_in) then
           if counter_signal = "1111" then
                counter_signal <= (others => '0');
           else
                counter_signal <= counter_signal + 1;
           end if;
        end if;
    end if;
end process;

data_out <= std_logic_vector(counter_signal);

end Behavioral;