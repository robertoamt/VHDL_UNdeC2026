
# ============================================================================
# run.do - Compile & simulate VHDL design + testbench in Questa/ModelSim
# Project structure (ejemplo):
#   ./design/  -> RTL VHDL
#   ./tb/      -> Testbench VHDL
#
# Uso:
#   vsim -c -do run.do      ;# modo consola
#   vsim -do run.do         ;# modo GUI
#
# Ajustá la variable TOP si tu testbench tiene otro nombre.
# ============================================================================

# -----------------------------
# Configuración de usuario
# -----------------------------
set RTL_DIR rtl
set TB_DIR  tb
set WORK_LIB work
set TOP data_gen_tb      ;# <-- Cambiar si tu testbench se llama distinto
set VHDL_STD "-2008" ;# Podés usar "-93" o "-2002" si lo necesitás

# -----------------------------
# Función simple para imprimir banners
# -----------------------------
proc banner {msg} {
    puts "\n====================================================================="
    puts "  $msg"
    puts "=====================================================================\n"
}

set wlft_files [glob -nocomplain wlft*]
if {[llength $wlft_files] > 0} {
    puts "Eliminando archivos wlft: $wlft_files"
    file delete -force {*}$wlft_files
}

# -----------------------------
# 0. Librería work
# -----------------------------
banner "SETTING UP LIBRARY '$WORK_LIB'"

# Borra librería previa si existe
if {[file exists $WORK_LIB]} {
    vdel -lib $WORK_LIB -all
}

# Crea y mapea librería work
vlib $WORK_LIB
vmap work $WORK_LIB

# -----------------------------
# 1. Compilar RTL (VHDL)
# -----------------------------
banner "COMPILING RTL VHDL FROM '$RTL_DIR'"

set rtl_files [lsort [concat \
    [glob -nocomplain -directory $RTL_DIR -types f -tails *.vhd] \
    [glob -nocomplain -directory $RTL_DIR -types f -tails *.vhdl] ]]

if {[llength $rtl_files] == 0} {
    puts "WARNING: No VHDL files found in $RTL_DIR"
} else {
    foreach f $rtl_files {
        set fullpath "$RTL_DIR/$f"
        puts ">>> [vcom] $fullpath"
        # Quita el catch al principio si querés ver el error crudo de vcom
        if {[catch {eval vcom $VHDL_STD \"$fullpath\"} errmsg]} {
            puts "ERROR: vcom failed for file $fullpath"
            puts "       vcom says: $errmsg"
            quit -code 1
        }
    }
}

# -----------------------------
# 2. Compilar TB (VHDL)
# -----------------------------
banner "COMPILING TESTBENCH VHDL FROM '$TB_DIR'"

set tb_files [lsort [concat \
    [glob -nocomplain -directory $TB_DIR -types f -tails *.vhd] \
    [glob -nocomplain -directory $TB_DIR -types f -tails *.vhdl] ]]

if {[llength $tb_files] == 0} {
    puts "WARNING: No VHDL files found in $TB_DIR"
} else {
    foreach f $tb_files {
        set fullpath "$TB_DIR/$f"
        puts ">>> [vcom] $fullpath"
        if {[catch {eval vcom $VHDL_STD \"$fullpath\"} errmsg]} {
            puts "ERROR: vcom failed for file $fullpath"
            puts "       vcom says: $errmsg"
            quit -code 1
        }
    }
}

# -----------------------------
# 3. Simulación
# -----------------------------
banner "STARTING SIMULATION: $TOP"

# Elaborar y correr
vsim -voptargs=+acc $WORK_LIB.$TOP

# Si estás en GUI, agregamos waves
if {![batch_mode]} {
    add wave -r /*
}
run 200ms

# Si estás en batch (-c), terminamos
if {[batch_mode]} {
    quit -f
}
# vsim -do run.do