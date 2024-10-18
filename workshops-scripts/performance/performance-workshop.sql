--Create viewCount indexed column

update	Posts
set		ViewCount_Indexed = ViewCount;

CREATE NONCLUSTERED INDEX IDX_POSTS_VIEWCOUNT ON Posts(ViewCount_Indexed);