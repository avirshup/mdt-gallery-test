FROM andrewosh/binder-base

RUN pip install moldesign
RUN echo y | conda install -c omnia openmm
RUN pip install https://github.com/pandegroup/pdbfixer/archive/v1.2.tar.gz

USER root

RUN apt-get update
RUN apt-get install -y \
  openbabel \
  python-openbabel

RUN apt-get update && apt-get install -y \
  cmake \
  python-h5py \
  g++ \
  wget \
  git \
  gfortran \
 && cd /opt \
   && wget -nv https://github.com/sunqm/pyscf/archive/v1.1.1.tar.gz \
   && tar xvzf v1.1.1.tar.gz && rm v1.1.1.tar.gz \
   && mv pyscf-1.1.1 pyscf \
 && cd /opt/pyscf/lib \
   && mv CMakeLists.txt CMakeLists.txt.old \
   && sed -e "s/libcint\.git/qcint.git/" CMakeLists.txt.old > CMakeLists.txt \
   && mkdir build && cd build && cmake .. && make \
 && apt-get -y remove --purge \
     cmake \
     g++ \
     wget \
     git \
     gfortran


RUN jupyter nbextension enable --python widgetsnbextension
RUN jupyter nbextension enable --python nbmolviz
