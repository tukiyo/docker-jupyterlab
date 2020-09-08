FROM ubuntu:20.04

RUN apt update \
 && apt install -y wget vim curl gawk make gcc \
 && apt clean

RUN wget -q "https://repo.continuum.io/archive/Anaconda3-2019.03-Linux-x86_64.sh" \
  && sh ./Anaconda3-2019.03-Linux-x86_64.sh -b \
  && rm -f Anaconda3-2019.03-Linux-x86_64.sh \
  && curl -sL "https://deb.nodesource.com/setup_10.x" | bash -
RUN apt install -y nodejs \
  && apt clean

ENV PATH=$PATH:/root/anaconda3/bin

RUN pip install gspread \
 && pip install oauth2client

WORKDIR /workspace
VOLUME /workspace
EXPOSE 8888

CMD ["jupyter-lab", "--ip=0.0.0.0","--port=8888" ,"--no-browser", "--allow-root", "--LabApp.token=''"]
