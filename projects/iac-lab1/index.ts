import * as pulumi from "@pulumi/pulumi";
import * as aws from '@pulumi/aws';
import {join} from 'path';
import * as mime from 'mime-types';
import { readdir } from "fs/promises";

// Setting configurations
const config = new pulumi.Config();
const siteDir = config.require('siteDir');

// Creating an AWS S3 Bucket with an logical name

const bucket = new aws.s3.Bucket(
    'my-bucket', 
    {
        website: {
            indexDocument: 'index.html'
        }
    }
);

readdir(siteDir)
    .then(files => {
        files.forEach(file => {
            const filePath = join(siteDir, file);
            const mimeType = mime.lookup(filePath);
            
            const obj = new aws.s3.BucketObject(file, {
                bucket: bucket,
                source: new pulumi.asset.FileAsset(filePath),
                acl: 'public-read',
                contentType: mimeType.toString()
            });
        })
    })
    .catch(error => console.error);


// Exporting the name of the bucket
export const bucketName = bucket.bucket;

// Exporting the bucket endpoint
export const bucketEndpoint =pulumi.interpolate`http://${bucket.websiteEndpoint}`;