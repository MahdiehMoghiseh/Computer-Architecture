.data
newline:    .asciiz "\n"
.text
.globl main
main:

    li $v0, 5
    syscall                 #  n 
    
    addi $s7, $v0, 0            
    mul $s6, $v0, 4         # array length  
    
    addi $a0, $s6, 0           #allocate memory 
    li $v0, 9               
    syscall 
    addi $s5,$v0, 0            # s5 = pointer of array 
    
    addi $t0, $s5, 0           
    addu $t1, $s5, $s6      



for1:
    
    beq $t0, $t1, endfor1   # if t0 = t1 end
    li $v0, 5               # get integer
    syscall
    
    sw $v0, 0($t0)        
    addi $t0, $t0, 4       
    
    b for1

endfor1:

    addi $a0, $s5, 0           
    addu $a1, $s5, $s6      
    jal quicksort           # call quicksort



    # print 
    addi $t0, $s5, 0           
    addu $t1, $s5, $s6      
prfor:
    
    beq $t0, $t1, endprfor # if t0 = t1 end
    
    lw $a0, 0($t0)
    li $v0, 1               # print ineteger
    syscall
    
    # print new line
    li $v0, 4
    la $a0, newline
    syscall
    
    addi $t0, $t0, 4 
    
    b prfor

endprfor:
    
        li $v0, 10
        syscall # exit  	

    
quicksort : 
    	addi $sp, $sp, -20		# room for 5

	sw $a0, 0($sp)			
	sw $a1, 4($sp)			
	sw $ra, 12($sp)			  
	
	 
	subu $t0 , $a1 , $a0   		
	srl $t0 , $t0 , 2      		   
	
	beq $t0 , $zero , endif 	  
	addi $t1 , $zero , 1 		 
	beq $t0 , $t1 , endif   
	
	addiu $a1 , $t0 , -1 		 
	li $v0 , 42 			# generate random for pivot index
	syscall  
	
	mul $a0 , $a0 , 4 		
	
	lw $t2 , 0($sp) 		
	addu $a2 , $a0 , $t2 		
	
	lw $a0 , 0($sp)  	
	lw $a1 , 4($sp) 		
	
	jal partition    
	
	
	sw $a2, 16($sp)			
	sw $a3, 20($sp)			
	
	
	jal quicksort   
	
	lw $a0 , 16($sp)	
	lw $a1, 20($sp)  
	
	jal quicksort 
	
	
	lw $ra , 12($sp) 	# restore return address
	addi $sp, $sp, 20	# restore stack size
	jr $ra			# back to caller
		
	
endif :   
	lw $ra , 12($sp) 	# restore return address  
	addi $sp, $sp, 20	# restore return address
	jr $ra 	 
	

partition: 			

	addi $sp, $sp, -16	# room for 4

	sw $a0, 0($sp)		# a0 = first
	sw $a1, 4($sp)		# a1 = last + 1
	sw $a2, 8($sp)		# pivot
	sw $ra, 12($sp)		 
	
	lw $t2 , 0($a2) 	# t2 = array[pivot]
	 
	
	addi $t1 , $a1, 0  	
	addi $a1 , $a2, 0 		
	jal swap 		 
	
	
	addu $t3 , $a0 , 4 	# t3 = j  
	addi $t5 , $t3, 0 		# t5 = i
	
	jal for2 
	
	addiu $t5 , $t5 , -4 	
	 
	
	lw $a0, 0($sp)		
	
	addi $a1 , $t5, 0 		
	
	jal swap 		 
	
	lw $a0 , 0($sp) 	 
	addi $a1 , $t5, 0 		
	addi $a2 , $t5 , 4 	 
	lw $a3 , 4($sp)		
	
	lw $ra , 12($sp)
	addi $sp, $sp, 16	
	jr $ra	
	
for2 :   
	addi $sp, $sp, -4	
	sw $ra, 0($sp)		
	b help 

help :
	bgeu $t3, $t1 , endfor2
	lw $t4 , 0($t3) 	 
	
		
	bgeu $t2 , $t4 ,  fif
	addu $t3 , $t3 , 4 	# j++
	
	b help 

fif : 
	addi $a0 , $t3, 0 		
	addi $a1 , $t5, 0		
	
	jal swap   
	
	addu $t3 , $t3 , 4 	# j++
	addu $t5 , $t5 , 4 	# i++
	
	b help  

endfor2 :   
	lw $ra , 0($sp) 	# restore return address
	addi $sp, $sp, 4	# restore stack size
	jr $ra			# back
swap:				

	addi $sp, $sp, -8	# room for two

	sw $a0, 0($sp)		
	sw $a1, 4($sp)		

	lw $s0, 0($a0)		
	
	lw $s1 , 0($a1)		

	sw $s1 , 0($a0)		
	sw $s0, 0($a1)		


	addi $sp, $sp, 8	# restore stack size
	jr $ra			# back to the caller    
    
