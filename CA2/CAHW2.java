import java.beans.IntrospectionException;
import java.math.BigInteger;
import java.security.Signature;
import java.security.KeyStore.Entry;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.zip.InflaterInputStream;

import javax.security.auth.kerberos.KerberosCredMessage;

public class CAHW2 {
    static Map instr = new HashMap<>();
    static Map instr2 = new HashMap<>();
    static Map instr3 = new HashMap<>();
    static String[] shiftInstrs = { "sll", "srl", "sra", "sllv", "srlv", "srav" };
    static Map registers = new HashMap<>();

    public static void main(String[] args) {
        // R-types

        instr.put("add", "100000");
        instr.put("addu", "100001");
        instr.put("and", "100110");
        instr.put("nor", "100111");
        instr.put("or", "100101");
        instr.put("xor", "100110");
        instr.put("sll", "000000");
        instr.put("sllv", "000100");
        instr.put("slt", "101010");
        instr.put("sltu", "101011");
        instr.put("sra", "000011");
        instr.put("srav", "000111");
        instr.put("srl", "000010");
        instr.put("srlv", "000110");
        instr.put("break", "001101");
        instr.put("syscall", "001100");
        instr.put("sub", "100010");
        instr.put("subu", "100011");
        instr.put("mult", "011000");
        instr.put("multu", "011001");
        instr.put("div", "010110");
        instr.put("divu", "011011");
        instr.put("jalr", "001001");
        instr.put("jr", "001000");
        instr.put("mfhi", "010000");
        instr.put("mflo", "010010");
        instr.put("mthi", "010001");
        instr.put("mtlo", "010011");

        // I-types
        instr2.put("addi", "001000");
        instr2.put("addiu", "001001");
        instr2.put("andi", "001100");
        instr2.put("beq", "000100");
        instr2.put("bgez", "000001");
        instr2.put("bgtz", "000111");
        instr2.put("blez", "000110");
        instr2.put("bltz", "000001");
        instr2.put("bne", "000101");
        instr2.put("lb", "100000");
        instr2.put("lbu", "100100");
        instr2.put("lh", "100001");
        instr2.put("lhu", "100101");
        instr2.put("lui", "001111");
        instr2.put("lw", "100011");
        instr2.put("lwc1", "110001");
        instr2.put("ori", "001101");
        instr2.put("sb", "101000");
        instr2.put("slti", "001010");
        instr2.put("sltiu", "001011");
        instr2.put("sh", "101001");
        instr2.put("sw", "101011");
        instr2.put("swc1", "111001");
        instr2.put("xori", "001110");

        // J-types

        instr3.put("j", "000010");
        instr3.put("jal", "000011");

        // registers
        registers.put("$zero", "00000");
        registers.put("$at", "00001");
        registers.put("$v0", "00010");
        registers.put("$v1", "00011");
        registers.put("$a0", "00100");
        registers.put("$a1", "00101");
        registers.put("$a2", "00110");
        registers.put("$a3", "00111");
        registers.put("$t0", "01000");
        registers.put("$t1", "01001");
        registers.put("$t2", "01010");
        registers.put("$t3", "01011");
        registers.put("$t4", "01100");
        registers.put("$t5", "01101");
        registers.put("$t6", "01110");
        registers.put("$t7", "01111");
        registers.put("$s0", "10000");
        registers.put("$s1", "10001");
        registers.put("$s2", "10010");
        registers.put("$s3", "10011");
        registers.put("$s4", "10100");
        registers.put("$s5", "10101");
        registers.put("$s6", "10110");
        registers.put("$s7", "10111");
        registers.put("$t8", "11000");
        registers.put("$t9", "11001");
        registers.put("$k0", "11010");
        registers.put("$k1", "11011");
        registers.put("$gp", "11100");
        registers.put("$sp", "11101");
        registers.put("$fp", "11110");
        registers.put("$ra", "11111");
        //////////////////////////////////
        Scanner input = new Scanner(System.in);
        String str = input.next();
        if (str.equals("Assembler")) {
            Assembler();
        } else if (str.equals("Disassembler")) {
            Disassembler();
        }
    }

    public static void Assembler() {
        Scanner input = new Scanner(System.in);
        while (input.hasNext()) {
            String str = input.nextLine();
            String[] strs = new String[4];
            strs = str.split(" ");
            if (instr.get(strs[0]) != null) {
                String op = "000000";
                String rs = "00000";
                String rt = registers.get(strs[2]).toString();
                String rd = registers.get(strs[1]).toString();
                String shamt = "00000";
                String funct = instr.get(strs[0]).toString();

                if (registers.get(strs[3]) == null) {
                    rs = "00000";
                    shamt = Integer.toBinaryString(Integer.parseInt(strs[3]));
                    if (shamt.length() < 5) {
                        shamt = add(shamt, 5);
                    }
                } else {
                    rs = registers.get(strs[3]).toString();
                }

                String binary = op + rs + rt + rd + shamt + funct;
                String answer = ToHex(binary);
                if (answer.length() < 8) {
                    answer = add(answer, 8);
                }
                System.out.println("R-Type");
                System.out.println("0x" + answer);
                System.out.println("op: " + op);
                System.out.println("rs: " + rs);
                System.out.println("rt: " + rt);
                System.out.println("rd: " + rd);
                System.out.println("shamt: " + shamt);
                System.out.println("funct: " + funct);
            } else if (instr2.get(strs[0]) != null) {
                String op = instr2.get(strs[0]).toString();
                String rs = registers.get(strs[3]).toString();
                String rt = registers.get(strs[1]).toString();
                String constantOraddress = Integer.toBinaryString(Integer.parseInt(Hex(strs[2]), 16));
                if (constantOraddress.length() < 16) {
                    constantOraddress = add(constantOraddress, 16);
                }
                String binary = op + rs + rt + constantOraddress;
                String answer = ToHex(binary);
                System.out.println("I-Type");
                System.out.println("0x" + answer);
                System.out.println("op: " + op);
                System.out.println("rs: " + rs);
                System.out.println("rt: " + rt);
                System.out.println("constant or address: " + constantOraddress);
            } else {
                String op = instr3.get(strs[0]).toString();
                String address = Integer.toBinaryString(Integer.parseInt(Hex(strs[1]), 16));

                if (address.length() < 26) {
                    address = add(address, 26);
                }

                String binary = op + address;
                String answer = ToHex(binary);
                System.out.println("J-Type");
                System.out.println("0x" + answer);
                System.out.println("op: " + op);
                System.out.println("address: " + address);
            }
        }
    }

    public static void Disassembler() {
        Scanner input = new Scanner(System.in);
        while (input.hasNext()) {
            String str = input.nextLine();
            str = Hex(str);
            str = Integer.toBinaryString(Integer.parseInt(str, 16));
            if (str.length() < 32) {
                str = add(str, 32);
            }
            if (str.substring(0, 6).equals("000000")) {

                // R-type!
                String op = "000000";
                String rs = str.substring(6, 11);
                String rt = str.substring(11, 16);
                String rd = str.substring(16, 21);
                String shamt = str.substring(21, 26);
                String funct = str.substring(26);
                String key1 = "";
                String key2 = rs;
                String key3 = rt;
                String key4 = rd;
                for (Object key : instr.keySet()) {
                    if (instr.get(key.toString()).equals(funct)) {
                        key1 = key.toString();
                    }
                }
                for (Object key : registers.keySet()) {
                    if (registers.get(key.toString()).equals(rs)) {
                        key2 = key.toString();
                    } else if (registers.get(key.toString()).equals(rt)) {
                        key3 = key.toString();
                    } else if (registers.get(key.toString()).equals(rd)) {
                        key4 = key.toString();
                    }
                }
                if (key4.contains("0") || key4.contains("1")) {
                    key4 = Integer.toString(Integer.parseInt(key4, 2) / 4);
                }
                String answer = key1 + " " + key3 + " " + key2 + " " + key4;
                System.out.println(answer);
                System.out.println("R-type");
                System.out.println("op: " + op);
                System.out.println("rs: " + rs);
                System.out.println("rt: " + rt);
                System.out.println("rd: " + rd);
                System.out.println("shamt: " + shamt);
                System.out.println("funct: " + funct);
            }
            for (Object key : instr2.keySet()) {
                if (instr2.get(key.toString()).equals(str.substring(0, 6))) {
                    // I-Type
                    String op = str.substring(0, 6);
                    String rs = str.substring(6, 11);
                    String rt = str.substring(11, 16);
                    String constantOraddress = str.substring(16);
                    String answer = key.toString() + " " + registers.get(rt) + " 0x"
                            + ToHex(constantOraddress) + " " + registers.get(rs);

                    System.out.println(answer);
                    System.out.println("I-type");
                    System.out.println("op: " + op);
                    System.out.println("rs: " + rs);
                    System.out.println("rt: " + rt);
                    System.out.println("constant or address: " + constantOraddress);
                }
            }
            for (Object key : instr3.keySet()) {
                if (instr3.get(key.toString()).equals(str.substring(0, 6))) {
                    String op = str.substring(0, 6);
                    String address = str.substring(6);
                    String answer = key.toString() + " 0x" + ToHex(address);
                    System.out.println(answer);
                    System.out.println("J-Type");
                    System.out.println("op: " + op);
                    System.out.println("address: " + address);
                }
            }
        }
    }

    public static String ToHex(String str) {
        return new BigInteger(str, 2).toString(16);
    }

    public static String Hex(String str) {
        return str.replace("0x", "");
    }

    public static String add(String str, int c) {
        String help = "";
        for (int i = 0; i < c - str.length(); i++) {
            help += "0";
        }
        str = help + str;
        return str;
    }
}
