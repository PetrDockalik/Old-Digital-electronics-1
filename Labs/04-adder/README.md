# Lab 4: Binary adder

## Preparation

### Half-adder

| **B** | **A** | **Carry (half)** | **S (half)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 0 |
| 0 | 1 | 0 | 1 |
| 1 | 0 | 0 | 1 |
| 1 | 1 | 1 | 0 |

![and_gates](../../Images/4-1.png)

![and_gates](../../Images/sim1.jpg)

### Full-adder

| **Cin** | **B** | **A** | **Cout (full)** | **S (full)** |
| :-: | :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 | 1 |
| 0 | 1 | 0 | 0 | 1 |
| 0 | 1 | 1 | 1 | 0 |
| 1 | 0 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 | 0 |
| 1 | 1 | 0 | 1 | 0 |
| 1 | 1 | 1 | 1 | 1 |

![and_gates](../../Images/4-2.png)

![and_gates](../../Images/sim2.jpg)

### Schematic

![and_gates](../../Images/sch41.jpg)
![and_gates](../../Images/sch42.jpg)