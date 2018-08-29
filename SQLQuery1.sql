use bookshops
go

create fulltext catalog FullCat as default
go

create fulltext index on Shops (NameShop) key index [PK__Shops__F3AB612BAF3A6987]
go

alter fulltext index on Shops start update population
go

select NameShop from Shops 
where freetext(NameShop, 'reading')
go

--------------------------------------------------------------------------

create fulltext index on Books (NameBook) key index [PK__Books__73160ABED6115794]
go

alter fulltext index on Books start update population
go

select NameBook from Books 
where contains(NameBook, 'isabout(программирование weight(.1), код weight(.3), fun weight(.5))')
go

--------------------------------------------------------------------------

create fulltext index on Themes (NameTheme) key index [PK__Themes__C8A5A0ABA28793CE]
go

alter fulltext index on Themes start update population
go

select NameBook, FirstName +' '+ LastName as 'Name Author', NameTheme
from Books b, Authors a, Themes th
where b.ID_THEME = th.ID_THEME
and
b.ID_AUTHOR = a.ID_AUTHOR
and
contains(NameTheme, 'isabout(программирование weight(.3), Базы weight(.5), Интернет weight(.6))')
go

-----------------------------------------------------------------------

select sh.NameShop, c.NameCountry, b.NameBook, COUNT(s.Quantity) as 'Count'
from Books b, Shops sh, Sales s, Country c
where b.ID_BOOK = s.ID_BOOK
and
s.ID_SHOP =  sh.ID_SHOP
and
sh.ID_COUNTRY = c.ID_COUNTRY
and
s.DateOfSale > '2018-07-10'
and
contains(b.NameBook, 'программирование or схемотехника or код')
group by NameShop, NameCountry, b.NameBook
go