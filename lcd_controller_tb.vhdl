LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY lcd_controller_tb IS
END lcd_controller_tb;

ARCHITECTURE behavior OF lcd_controller_tb IS

component lcd_controller IS
PORT(
     clk : IN STD_LOGIC; --system clock
     reset_n : IN STD_LOGIC; --active low reinitializes lcd
     lcd_enable : IN STD_LOGIC; --latches data into lcd controller
     lcd_bus : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
     busy : OUT STD_LOGIC := '1'; --lcd controller
     rw, rs, e : OUT STD_LOGIC;
     lcd_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0); --data signals
     lcd_on : OUT std_logic; --LCD Power ON/OFF
     lcd_blon : OUT std_logic);
end component;

signal slcd_busy : IN STD_LOGIC;
signal sclk : IN STD_LOGIC;
signal slcd_clk : OUT STD_LOGIC;
signal sreset_n : OUT STD_LOGIC;
signal slcd_enable : buffer STD_LOGIC;
signal slcd_bus : OUT STD_LOGIC_VECTOR(9 DOWNTO 0));

  BEGIN

    PROCESS(sclk)
      VARIABLE char : INTEGER RANGE 0 TO 12 := 0;
      BEGIN
        IF(sclk'EVENT AND sclk = '1') THEN
        IF(slcd_busy = '0' AND slcd_enable = '0') THEN
        slcd_enable <= '1';
        IF(char < 12) THEN
          char := char + 1;
        END IF;

        CASE char IS
          WHEN 1 => slcd_bus <= "1000110001";
          WHEN 2 => slcd_bus <= "1000110010";
          WHEN 3 => slcd_bus <= "1000110011";
          WHEN 4 => slcd_bus <= "1000110100";
          WHEN 5 => slcd_bus <= "1000110101";
          WHEN 6 => slcd_bus <= "1000110110";
          WHEN 7 => slcd_bus <= "1000110111";
          WHEN 8 => slcd_bus <= "1000111000";
          WHEN 9 => slcd_bus <= "1000111001";
          WHEN 10 => slcd_bus<= "1001000001";
          WHEN 11 => slcd_bus<= "1001000010";
          WHEN OTHERS => slcd_enable <= '0';
          END CASE;
          ELSE
          slcd_enable <= '0';
          END IF;
        END IF;
        lcd_clk     <= slcd_clk;
        reset_n     <= sreset_n;
        lcd_enable  <= slcd_enable;
        lcd_bus     <= slcd_bus;
      END PROCESS;

      reset_n <= '1';
  lcd_clk <= clk;
END behavior;
