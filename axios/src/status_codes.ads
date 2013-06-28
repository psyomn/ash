-- @author Simon Symeonidis
-- @date 
-- This just contains some static data on the 
package Status_Codes is

  OK             : constant := 200; 
  CREATED        : constant := 201;
  ACCEPTED       : constant := 202;

  BAD_REQUEST    : constant := 400;
  UNAUTHORIZED   : constant := 401; 
  FORBIDDEN      : constant := 403;
  NOT_FOUND      : constant := 404;

  INTERNAL_ERROR : constant := 500;

end Status_Codes;
