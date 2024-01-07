NC_IP=162.0.217.17
NC_PORT=21098
NC_USER=macipqfl
TARGET=public_html

.PHONY: serve install clean

$(TARGET):
	zola build -o $@

serve:
	zola serve

$(TARGET).tgz: $(TARGET)
	tar czf $@ $<

install: $(TARGET).tgz
	scp -rP $(NC_PORT) $< $(NC_USER)@$(NC_IP):/home/$(NC_USER)/
	ssh $(NC_USER)@$(NC_IP) -p $(NC_PORT) "rm -rf /home/$(NC_USER)/$(TARGET)/* && tar xzf $<"

clean:
	rm -f $(TARGET).tgz
	rm -rf $(TARGET)
