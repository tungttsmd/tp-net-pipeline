
DEVELOPMENT: Không cần chạy kèm folder pipeline-environment: 

	Máy của dev thường cài đầy đủ các path như git, java... nên có thể chạy riêng các pipeline.bat một cách bình thường

PRODUCTION: Bắt buộc phải chạy kèm folder pipeline-environment:

	Máy khách thường không có môi trường phù hợp, pipeline-environment là môi trường portable được viết để tối ưu 
	Chỉ cần có Window là chạy được.

	git: tốc độ từ curl download file cực kỳ chậm, git folder (git/) được thêm vào để có thể chạy git portable
	Việc dùng git portable sẽ tăng tốc clone dữ liệu, nén data và tốc độ nhanh hơn gấp đôi, gấp 3...