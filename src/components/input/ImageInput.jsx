import React from 'react';
import {Button} from '@material-ui/core';
import {url} from 'util/Api';
import Compress from 'compress.js';


const DummyData = ({title}) =>(
  <div style={{color:'#d9d9d9'}}>
    <h1><b>{title}</b></h1>
  </div>
)

function urltoFile(url, filename, mimeType){
  return (fetch(url)
      .then(function(res){return res.arrayBuffer();})
      .then(function(buf){return new File([buf], filename,{type:mimeType});})
  );
}

// eslint-disable-next-line
export default ({id, name, className, buttonLabel, dummyText, onChange, defaultValue}) => {
  const [imageURL, setImageURL] = React.useState(defaultValue?`${url}${defaultValue}`:null)

  React.useEffect(()=>{
    setImageURL(defaultValue?`${url}${defaultValue}`:null)
  }, [defaultValue])

  const putImageURL = e =>{
    const f = [...e.target.files]
    const compress = new Compress()
    compress.compress(f, {
      size: 1,          // Max size in MB
      resize: true
    }).then(file => {
        urltoFile(file[0].prefix+file[0].data, file[0].alt, file[0].ext)
          .then(resp => {
            try{
              setImageURL(URL.createObjectURL(resp))
              const data = {target: {name, files: [resp]}}
              onChange && onChange(data)
            } catch (error) {
              console.log(error)
            }
          })
    })
  }

  return(
    <React.Fragment>
      <div className={`text-center ${className?className:null}`} style={{width: 'fit-content'}}>
        <div style={style.imgPreviewBox}>
          {
            imageURL
            ? <img style={style.imgPreview} src={imageURL} alt={dummyText}/>
            : <DummyData title={dummyText ? dummyText : "Image"}/>
          }
        </div>
        <input accept="image/*" style={{display:"none"}} id={id} name={name} type="file" onChange={putImageURL}/>
        <label htmlFor={id}>
          <Button component="span" variant="contained" size="small">{buttonLabel?buttonLabel:"Choose Image"}</Button>
        </label>
      </div>
    </React.Fragment>
  )
}


const style = {
  imgPreviewBox: {
    height: 150,
    width: 150,
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    border: '0.5px solid var(--primary)',
    borderRadius: 5,
    marginBottom: 5,
    overflow: 'hidden'
  },
  imgPreview: {
    maxWidth: '100%',
    maxHeight: '100%'
  }
}