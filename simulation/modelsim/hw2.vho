-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "11/02/2022 02:37:45"

-- 
-- Device: Altera 5CSEMA4U23C6 Package UFBGA672
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	mux_x IS
    PORT (
	in_1 : IN std_logic;
	in_2 : IN std_logic;
	\select\ : IN std_logic;
	Rd_data : OUT std_logic
	);
END mux_x;

-- Design Ports Information
-- Rd_data	=>  Location: PIN_AE22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_2	=>  Location: PIN_AF21,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- select	=>  Location: PIN_AF22,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- in_1	=>  Location: PIN_AG21,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF mux_x IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_in_1 : std_logic;
SIGNAL ww_in_2 : std_logic;
SIGNAL \ww_select\ : std_logic;
SIGNAL ww_Rd_data : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \in_2~input_o\ : std_logic;
SIGNAL \select~input_o\ : std_logic;
SIGNAL \in_1~input_o\ : std_logic;
SIGNAL \Rd_data~0_combout\ : std_logic;
SIGNAL \ALT_INV_in_1~input_o\ : std_logic;
SIGNAL \ALT_INV_select~input_o\ : std_logic;
SIGNAL \ALT_INV_in_2~input_o\ : std_logic;

BEGIN

ww_in_1 <= in_1;
ww_in_2 <= in_2;
\ww_select\ <= \select\;
Rd_data <= ww_Rd_data;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_in_1~input_o\ <= NOT \in_1~input_o\;
\ALT_INV_select~input_o\ <= NOT \select~input_o\;
\ALT_INV_in_2~input_o\ <= NOT \in_2~input_o\;

-- Location: IOOBUF_X57_Y0_N19
\Rd_data~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => \Rd_data~0_combout\,
	devoe => ww_devoe,
	o => ww_Rd_data);

-- Location: IOIBUF_X55_Y0_N58
\in_2~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_2,
	o => \in_2~input_o\);

-- Location: IOIBUF_X55_Y0_N41
\select~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => \ww_select\,
	o => \select~input_o\);

-- Location: IOIBUF_X55_Y0_N75
\in_1~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_in_1,
	o => \in_1~input_o\);

-- Location: MLABCELL_X55_Y1_N30
\Rd_data~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \Rd_data~0_combout\ = ( \select~input_o\ & ( \in_1~input_o\ & ( \in_2~input_o\ ) ) ) # ( !\select~input_o\ & ( \in_1~input_o\ ) ) # ( \select~input_o\ & ( !\in_1~input_o\ & ( \in_2~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000001100110011001111111111111111110011001100110011",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	datab => \ALT_INV_in_2~input_o\,
	datae => \ALT_INV_select~input_o\,
	dataf => \ALT_INV_in_1~input_o\,
	combout => \Rd_data~0_combout\);

-- Location: LABCELL_X13_Y12_N3
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


