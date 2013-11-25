create procedure GetLoginDetail_SP
(
@Username nvarchar(50),
@password nvarchar(50)

)
as
begin
select username, [password] from tbllogin where UserName=@username and [Password]=@password
end