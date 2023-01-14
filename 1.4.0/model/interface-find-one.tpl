FindOne(ctx context.Context, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (*{{.upperStartCamelObject}}, error)                                 // 通过主键id查找数据
Finds(ctx context.Context, queries []Query, orders []Order) ([]*{{.upperStartCamelObject}}, error)                                           // 按条件查询，不分页
FindsByPage(ctx context.Context, queries []Query, page *Page, orders []Order) ([]*{{.upperStartCamelObject}}, int64, error)   // 分页查询
FindCount(ctx context.Context, queries []Query) (int64, error)                                                                             // 按条件查询记录条数