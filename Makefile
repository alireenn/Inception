NAME=Inception

all:	re

stop:
		@docker-compose -f ./srcs/docker-compose.yml down

clean:	stop
		@rm -rf /home/${USER}/data
		@docker container rm '$(docker container ps -aq)'

fclean:	clean
		@docker system prune -a

re:	
		@sudo sh srcs/Inception_prep.sh 
		@docker-compose -f srcs/docker-compose.yml up --build 

.PHONY:	all stop clean re
