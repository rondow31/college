uses CRT;

const
  MaxSize = 10; // Максимальный размер стека
  
type  
  PNode = ^Node;
  Node = record    
    Data: Integer;
    Next: PNode;  
  end;
  
  Stack = record
    Top: PNode;  
  end;

// Инициализация стека
procedure InitializeStack(var S: Stack);
begin
  S.Top := nil;
end;

// Проверка стека на пустоту
function IsEmpty(var S: Stack): Boolean;
begin
  IsEmpty := S.Top = nil;
end;

// Проверка стека на полноту
function IsFull(var S: Stack): Boolean;
begin
  IsFull := False;
end;

// Добавление элемента в стек
procedure Push(var S: Stack; Value: Integer);
var
  NewNode: PNode;
begin
  if not IsFull(S) then  
  begin
    New(NewNode);    
    NewNode^.Data := Value;
    NewNode^.Next := S.Top;    
    S.Top := NewNode;
    Writeln('Элемент ', Value, ' добавлен в стек.');  
  end
  else    
    Writeln('Стек полон, невозможно добавить элемент.');
end;

// Удаление элемента из стека
function Pop(var S: Stack): Integer;
var  
  Temp: PNode;
  del:integer;
begin  
  if not IsEmpty(S) then
  begin    
    Temp := S.Top;
    del := Temp^.Data;
    Pop := Temp^.Data;
    S.Top := Temp^.Next;    
    Dispose(Temp);
    Writeln('Удаленный элемент ',del);
  end  
  else
  begin    
    Writeln('Стек пуст, невозможно удалить элемент.');    
    Pop := 0;
  end;
end;

// Отобразить содержимое стека
procedure DisplayStack(S: Stack);
var  
  Temp: PNode;
begin  
  Temp := S.Top;  
  Writeln('Содержимое стека:');
  while Temp <> nil do  
  begin    
    Write(Temp^.Data, ' ');
    Temp := Temp^.Next;  
  end;
  Writeln;
end;

var  
  DynamicStack: Stack;
  StaticStack: array[1..MaxSize] of Integer;  
  Operation: Char;
  Value: Integer;  
  UseDynamic: Boolean;
  StaticTop: Integer; // Для отслеживания вершины статического стека

begin
  UseDynamic := True; // Использовать динамическую память по умолчанию
  StaticTop := 0; // Инициализация вершины статического стека

  InitializeStack(DynamicStack); // Инициализация динамического стека
  
  repeat    
    ClrScr;    
    Writeln('Меню операций:');
    Writeln('1. Изменить тип памяти (', If UseDynamic Then 'Текущий: Динамическая' Else 'Текущий: Статическая', ')');    
    Writeln('2. Добавить элемент в стек');
    Writeln('3. Удалить элемент из стек');    
    Writeln('4. Вывести содержимое стека');
    Writeln('0. Выход');    
    Operation := ReadKey;
    
    case Operation of
      '1': // Изменить тип памяти      
      begin        
        UseDynamic := not UseDynamic;        
        ClrScr;
        if UseDynamic then          
          Writeln('Тип памяти изменен на Динамическую')
        else          
          Writeln('Тип памяти изменен на Статическую');
        
        Writeln('Нажмите любую клавишу для продолжения...');        
        ReadKey; // Ждем нажатия любой клавиши
      end;      
      '2': // Добавление элемента в стек
      begin        
        ClrScr;
        Write('Введите значение элемента: ');        
        Readln(Value);
        
        if UseDynamic then          
          Push(DynamicStack, Value)
        else
        begin
          if StaticTop < MaxSize then
          begin
            Inc(StaticTop);
            StaticStack[StaticTop] := Value;
            Writeln('Элемент ', Value, ' добавлен в стек.');
          end
          else
            Writeln('Стек полон, невозможно добавить элемент.');
        end;
        
        Writeln('Нажмите любую клавишу для продолжения...');        
        ReadKey; // Ждем нажатия любой клавиши
      end;      
      '3': // Удаление элемента из стека
      begin        
        ClrScr;
        if UseDynamic then
          Pop(DynamicStack)
        else
        begin
          if StaticTop > 0 then
          begin
            Writeln('Удаленный элемент: ', StaticStack[StaticTop]);
            Dec(StaticTop);
          end
          else
            Writeln('Стек пуст, невозможно удалить элемент.');
        end;
        
        Writeln('Нажмите любую клавишу для продолжения...');        
        ReadKey; // Ждем нажатия любой клавиши
      end;      
      '4': // Вывод содержимого стека
      begin        
        ClrScr;
        if UseDynamic then          
          DisplayStack(DynamicStack)
        else
        begin
          Writeln('Содержимое статического стека:');
          for Value := 1 to StaticTop do
            Write(StaticStack[Value], ' ');
          Writeln;
        end;
        
        Writeln('Нажмите любую клавишу для продолжения...');        
        ReadKey; // Ждем нажатия любой клавиши
      end;      
      '0': // Выход из программы
      begin        
        ClrScr;
        Writeln('Программа завершена.');        
        Writeln('Нажмите любую клавишу для выхода...');
        ReadKey;
      end;
    end;
  until Operation = '0';
end.