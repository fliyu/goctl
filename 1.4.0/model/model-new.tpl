
func new{{.upperStartCamelObject}}Model(conn *gorm.DB) *default{{.upperStartCamelObject}}Model {
	return &default{{.upperStartCamelObject}}Model{
		DB: conn,
	}
}
