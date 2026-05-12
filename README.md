# Book Management System in 8086 Assembly Language

## Overview

The Book Management System is a console-based application developed using 8086 Assembly Language for DOS environments. The project demonstrates how low-level programming concepts can be used to create a functional inventory and billing system.

This application allows users to:

* View available books
* Purchase books
* Manage stock quantities
* Add items to a shopping cart
* View cart details
* Calculate the total bill

The project uses DOS interrupts (`int 21h`) for user input and output operations and is designed to run in an 8086 emulator such as EMU8086 or DOSBox.

---

# Features

## Available Books

The system contains three predefined books:

1. Math — Rs 500
2. Physics — Rs 600
3. Computer Science — Rs 700

## Main Menu Operations

### 1. View Books

Displays the list of available books with prices.

### 2. Buy Book

Allows the user to:

* Select a book
* Enter quantity
* Check stock availability
* Add books to the cart
* Automatically update inventory
* Calculate billing amount

### 3. View Cart

Displays:

* Purchased books
* Quantity of each book
* Subtotal per item
* Total bill amount

### 4. Exit

Terminates the program safely.

---

# Technologies Used

* 8086 Assembly Language
* DOS Interrupts (`int 21h`)
* EMU8086 / DOSBox Emulator

---

# Concepts Implemented

This project demonstrates several important assembly language concepts:

* Data segment management
* Conditional jumps
* Loops and iteration
* Arrays and indexing
* Arithmetic calculations
* Procedures/functions
* Stack operations (`push` / `pop`)
* String display using DOS interrupts
* Inventory management logic

---

# Project Structure

## Data Section

Contains:

* Menu strings
* Book names
* Prices
* Stock values
* Cart values
* Billing variables

## Text Section

Contains:

* Main menu logic
* Book purchasing system
* Cart viewing system
* Error handling
* Number printing procedure

---

# How the System Works

1. The user is shown the main menu.
2. The user selects an option.
3. If buying a book:

   * The system checks stock availability.
   * Updates cart and stock.
   * Calculates subtotal and total bill.
4. The cart can be viewed anytime.
5. The user can exit the application through the menu.

---

# Error Handling

The system handles:

* Invalid menu input
* Invalid book selection
* Invalid quantity
* Insufficient stock availability

Appropriate error messages are displayed to the user.

---

# Sample Output

```text
===============================================================
||                 BOOK MANAGEMENT SYSTEM                    ||
===============================================================
|| 1. View Books                                             ||
|| 2. Buy Book                                               ||
|| 3. View Cart                                              ||
|| 4. Exit                                                   ||
===============================================================
Enter Choice:
```

---

# Future Improvements

Possible future enhancements include:

* Add more books dynamically
* User authentication system
* File handling for permanent storage
* Search functionality
* Remove items from cart
* Admin panel for stock management
* Better user interface

---

# Learning Objectives

This project is ideal for students learning:

* Assembly Language Programming
* DOS Interrupts
* Low-level system programming
* Inventory management logic
* Basic billing systems

---

# Author

Developed as an educational Assembly Language project for learning and demonstration purposes.

---

