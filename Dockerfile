FROM andrewosh/binder-base

RUN conda config --set always_yes yes --set changeps1 no
RUN conda update -q conda


RUN conda install -c omnia openmm openbabel
RUN conda install numpy scipy matplotlib
RUN pip install moldesign

ENV PYTHONPATH=/opt:$PYTHONPATH

USER root

RUN apt-get update

RUN apt-get install -y \
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
   && mkdir build && cd build && cmake .. && make


RUN jupyter nbextension enable --python widgetsnbextension
RUN jupyter nbextension enable --python nbmolviz
RUN cp -r  /home/main/anaconda2/lib/python2.7/site-packages/moldesign/_notebooks/ /mdt-examples
ENV PYTHONPATH=/opt:$PYTHONPATH
WORKDIR /mdt-examples
