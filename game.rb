require_relative 'board'
require_relative 'player'
require_relative 'computer'
include Computer

win_array=[[0,1,2], [0,4,8], [0,3,6], [1,4,7], [2,5,8], [2,4,6], [3,4,5], [6,7,8]]

puts "Welcome to Tic-Tac-Toe!"

puts "These are the positons on the Tic Tac Toe Board."
puts " 0 | 1 | 2 "
puts "-----------"
puts " 3 | 4 | 5 "
puts "-----------"
puts " 6 | 7 | 8 "

puts "What type of game would you like to play? Type 1 for human vs. human, 2 for human vs. computer, and 3 for computer vs. computer."
mode=gets.chomp
while (mode!="1" && mode!="2" && mode!="3")
	puts "Invalid response: Please enter a 1, 2, or 3."
	mode=gets.chomp
end

if mode=="1"
	puts "Please enter your name."
	p1_name=gets.chomp
	puts "Would Player 1 like to be an X or an O?"
	p1_symbol=gets.chomp.upcase
	p1=Player.new(p1_name, p1_symbol, [])
		while (p1_symbol!="X" && p1_symbol!="O")
			puts "Invalid response: Please enter either 'X' or 'O'."
			p1_symbol=gets.chomp.upcase
		end
	if p1_symbol == "X"
		p2_symbol = "O"
	else
		p2_symbol = "X"
	end 
	puts "Player 2, please enter your name."
	p2_name=gets.chomp
	p2=Player.new(p2_name, p2_symbol, [])


	board=Board.new
	move_number=1
	win=false
	while win==false
		if move_number%2==1
			current_player=p1
		else 
			current_player=p2
		end
		board.display_board
		puts "#{current_player.name}: Where would you like to place your token (number must be between 0 and 8)?"
		location=gets.chomp.to_i
		while (0..8).to_a.include?(location)==false
			puts "Invalid response: Please submit a number between 0 and 8."
			location=gets.chomp.to_i
		end
		while board.entries[location]!=" "
			puts "That spot is already taken!"
			puts "#{current_player.name}: Where would you like to place your token (number must be between 0 and 8)?"
			location=gets.chomp.to_i
		end
		current_player.history << location
		board.modify_board(current_player, location)
		win_array.each do |element|
			if (current_player.history&element).sort==element
				win=true
			end
		end
		if win==true
			puts "#{current_player.name} wins the game!"
			board.display_board
		elsif move_number==9
			puts "It's a draw folks!"
			win=true
			board.display_board
		else
			move_number+=1
		end
	end
end

if mode=="2"
	puts "Would you like to be an X or an O?"
	p1_symbol=gets.chomp.upcase
	p1=Player.new("Human Player", p1_symbol, [])
		while (p1_symbol!="X" && p1_symbol!="O")
			puts "Invalid response: Please enter either 'X' or 'O'."
			p1_symbol=gets.chomp.upcase
		end
	if p1_symbol == "X"
		p2_symbol = "O"
	else
		p2_symbol = "X"
	end 
	p2=Player.new("Computer", p2_symbol, [])
	board=Board.new
	move_number=1
	win=false
	while win==false
		if move_number%2==1
			current_player=p1
			if move_number==1
				board.display_board
			end
			puts "Where would you like to place your token (number must be between 0 and 8)?"
			location=gets.chomp.to_i
			while (0..8).to_a.include?(location)==false
				puts "Invalid response: Please submit a number between 0 and 8."
				location=gets.chomp.to_i
			end
			while board.entries[location]!=" "
				puts "That spot is already taken!"
				puts "Where would you like to place your token (number must be between 0 and 8)?"
				location=gets.chomp.to_i
			end
			current_player.history << location
			board.modify_board(current_player, location)
			win_array.each do |element|
				if (current_player.history&element).sort==element
					win=true
				end
			end
			if win==true
				puts "You win."
				board.display_board
			elsif move_number==9
				puts "It's a draw folks!"
				win=true
				board.display_board
			else
				move_number+=1
				board.display_board
			end
		else
			current_player=p2
			location=Computer.optimal(p1.history,p2.history)
			current_player.history << location
			board.modify_board(current_player, location)
			win_array.each do |element|
				if (current_player.history&element).sort==element
					win=true
				end
			end
			if win==true
				puts "The computer wins."
				board.display_board
			elsif move_number==9
				puts "It's a draw folks!"
				win=true
				board.display_board
			else
				move_number+=1
				puts "Computer's move:"
				board.display_board
			end
		end
	end
else 
	
end

if mode == "3"
	#this conditional allows the computer to play .self, but I think computer.rb needs to be refactored with a class method that teaches game play without being reliant on another player
	p1=Player.new("Computer", "X", [])
	p2=Player.new("Computer", "0", [])
	board=Board.new
	move_number=1
	win=false
	while win==false
		if move_number%2==1
			current_player=p1
			if move_number==1
				board.display_board
			end
			
			location=Computer.optimal(p1.history,p2.history)
			current_player.history << location
			board.modify_board(current_player, location)
			win_array.each do |element|
				if (current_player.history&element).sort==element
					win=true
				end
			end
			if win==true
				puts "Player 1 wins"
				board.display_board
			elsif move_number==9
				puts "It's a draw folks!"
				win=true
				board.display_board
			else
				move_number+=1
				puts "Computer's move:"
				board.display_board
			end
		else
			current_player=p2
			location=Computer.optimal(p1.history,p2.history)
			current_player.history << location
			board.modify_board(current_player, location)
			win_array.each do |element|
				if (current_player.history&element).sort==element
					win=true
				end
			end
			if win==true
				puts "Player 2 wins"
				board.display_board
			elsif move_number==9
				puts "It's a draw folks!"
				win=true
				board.display_board
			else
				move_number+=1
				puts "Computer's move:"
				board.display_board
			end
		end
	end
	
	
	
end














