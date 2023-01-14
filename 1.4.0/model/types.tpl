
type (
	{{.lowerStartCamelObject}}Model interface{
		{{.method}}
	}

	default{{.upperStartCamelObject}}Model struct {
		DB *gorm.DB
	}

	{{.upperStartCamelObject}} struct {
		{{.fields}}
	}
)
