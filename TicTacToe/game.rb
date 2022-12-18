class Board
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @board = [[1,2,3],[4,5,6],[7,8,9]]
  end

  def placePiece(player, where)
    if where > 6 && where < 10
      @board[2][where%3-1] = player.playerSymbol
    elsif where > 3
      @board[1][where%3-1] = player.playerSymbol
    else
      @board[0][where%3-1] = player.playerSymbol
    end
  end

  def displayBoard()
    p "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    p "---------"
    p "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    p "---------"
    p "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
  end

  def checkWin(player)
    total = 0

    #row win
    for y in 0..2 do
      for x in 0..2 do
        if @board[y][x] == player.playerSymbol
          total += 1
        end
      end
      if total == 3
        return true
      else
        total = 0
      end
    end

    #column win
    for y in 0..2 do
      for x in 0..2 do
        if @board[x][y] == player.playerSymbol
          total += 1
        end
      end
      if total == 3
        return true
      else
        total = 0
      end
    end

    #check cross win
    for i in 0..2 do
      if @board[i][i] == player.playerSymbol
        total += 1
      end
    end
    if total == 3
      return true
    else
      total = 0
    end

    #anti cross win
    if @board[0][2] == player.playerSymbol && @board[1][1] == player.playerSymbol && @board[2][0] == player.playerSymbol
      return true
    end

    false
  end
end


class Player
  attr_reader :playerSymbol
  def initialize(playerSymbol)
    @playerSymbol = playerSymbol
  end
end

def playGame(p1,p2,board)
  while !checkWin
    
  end
end