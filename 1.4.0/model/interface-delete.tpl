Delete(ctx context.Context, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (int64, error)                    // 通过主键id删除数据，返回受影响行数
TxDelete(ctx context.Context, tx *gorm.DB, {{.lowerStartCamelPrimaryKey}} {{.dataType}}) (int64, error)     // 用于事务删除数据，由上层(如rpc层)调用Transaction去实现，返回受影响行数
Deletes(ctx context.Context, {{.lowerStartCamelPrimaryKey}}s []{{.dataType}}) (int64, error)                // 通过主键id批量删除数据，返回受影响行数
TxDeletes(ctx context.Context, tx *gorm.DB, {{.lowerStartCamelPrimaryKey}}s []{{.dataType}}) (int64, error) // 用于事务批量删除数据，由上层(如rpc层)调用Transaction去实现，返回受影响行数